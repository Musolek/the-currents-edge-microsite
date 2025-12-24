// MARK: - ML Service
// Services/MLService.swift

import Foundation
import CoreML
import NaturalLanguage

/// On-device machine learning for mood analysis and music recommendations
@Observable
class MLService {
    
    // MARK: - Singleton
    static let shared = MLService()
    
    // MARK: - Models (loaded lazily)
    private var sentimentModel: NLModel?
    private var recommendationModel: MLModel?
    
    private init() {
        setupSentimentAnalyzer()
    }
    
    // MARK: - Sentiment Analysis
    
    /// Analyzes text input to extract emotional valence and arousal
    /// - Parameter text: User's journal entry or mood description
    /// - Returns: Tuple of (valence: -1 to 1, arousal: -1 to 1)
    func analyzeSentiment(from text: String) -> (valence: Double, arousal: Double) {
        guard !text.isEmpty else {
            return (0.0, 0.0)
        }
        
        // Use NaturalLanguage framework for sentiment
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        
        let (sentiment, _) = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore)
        let sentimentScore = Double(sentiment?.rawValue ?? "0") ?? 0.0
        
        // Valence: sentiment score maps directly (-1 to 1)
        let valence = sentimentScore
        
        // Arousal: estimate from linguistic features
        let arousal = estimateArousal(from: text)
        
        return (valence, arousal)
    }
    
    /// Estimates arousal (energy level) from text features
    private func estimateArousal(from text: String) -> Double {
        let lowercased = text.lowercased()
        
        // High arousal keywords
        let highArousalWords = ["excited", "anxious", "stressed", "energetic", "intense", "overwhelming", "frantic", "restless"]
        let highArousalCount = highArousalWords.filter { lowercased.contains($0) }.count
        
        // Low arousal keywords
        let lowArousalWords = ["calm", "tired", "peaceful", "sleepy", "numb", "empty", "quiet", "still"]
        let lowArousalCount = lowArousalWords.filter { lowercased.contains($0) }.count
        
        // Punctuation density (more exclamation = higher arousal)
        let exclamationCount = text.filter { $0 == "!" }.count
        let questionCount = text.filter { $0 == "?" }.count
        let punctuationScore = Double(exclamationCount * 2 + questionCount) / 10.0
        
        // Combine signals
        let arousalScore = (Double(highArousalCount) - Double(lowArousalCount)) / 5.0 + punctuationScore
        
        // Clamp to [-1, 1]
        return max(-1.0, min(1.0, arousalScore))
    }
    
    /// Maps mood selection + optional journal text to precise emotional coordinates
    func extractMoodVector(mood: Mood, journalText: String?) -> (valence: Double, arousal: Double) {
        guard let text = journalText, !text.isEmpty else {
            // No journal text, use mood's baseline coordinates
            return (mood.valence, mood.arousal)
        }
        
        // Analyze text
        let (textValence, textArousal) = analyzeSentiment(from: text)
        
        // Blend mood baseline with text analysis (70% text, 30% mood)
        let blendedValence = 0.7 * textValence + 0.3 * mood.valence
        let blendedArousal = 0.7 * textArousal + 0.3 * mood.arousal
        
        return (blendedValence, blendedArousal)
    }
    
    // MARK: - Recommendation Engine
    
    /// Generates personalized playlist based on mood, context, and user history
    /// - Parameters:
    ///   - mood: Selected emotional state
    ///   - context: Optional activity context
    ///   - availableTracks: Pool of tracks to choose from
    ///   - userFeedback: Historical user interactions
    ///   - journalText: Optional text for refined sentiment
    /// - Returns: Ordered array of recommended tracks
    func recommendTracks(
        mood: Mood,
        context: Context?,
        availableTracks: [Track],
        userFeedback: [TrackFeedback],
        journalText: String? = nil
    ) -> [Track] {
        
        // 1. Get precise mood coordinates
        let (targetValence, targetArousal) = extractMoodVector(mood: mood, journalText: journalText)
        
        // 2. Apply context modifiers
        var adjustedValence = targetValence
        var adjustedArousal = targetArousal
        
        if let context = context {
            adjustedValence += context.valenceModifier
            adjustedArousal += context.energyModifier
            
            // Clamp to valid range
            adjustedValence = max(-1.0, min(1.0, adjustedValence))
            adjustedArousal = max(-1.0, min(1.0, adjustedArousal))
        }
        
        // 3. Score each track
        var scoredTracks: [(track: Track, score: Double)] = availableTracks.map { track in
            let score = computeTrackScore(
                track: track,
                targetValence: adjustedValence,
                targetArousal: adjustedArousal,
                userFeedback: userFeedback
            )
            return (track, score)
        }
        
        // 4. Sort by score (descending)
        scoredTracks.sort { $0.score > $1.score }
        
        // 5. Apply gentle mood elevation if enabled
        // (Nudge toward slightly higher valence without forcing)
        let finalTracks = applyMoodNudge(
            tracks: scoredTracks.map { $0.track },
            currentValence: adjustedValence
        )
        
        return finalTracks
    }
    
    /// Computes recommendation score for a single track
    private func computeTrackScore(
        track: Track,
        targetValence: Double,
        targetArousal: Double,
        userFeedback: [TrackFeedback]
    ) -> Double {
        
        // 1. Feature distance (lower = better match)
        // Normalize audio features from 0.0-1.0 to -1.0-1.0 to match mood coordinates
        let normalizedTrackValence = track.features.normalizedValence
        let normalizedTrackEnergy = track.features.normalizedEnergy
        
        let valenceDiff = normalizedTrackValence - targetValence
        let arousalDiff = normalizedTrackEnergy - targetArousal
        let featureDistance = sqrt(valenceDiff * valenceDiff + arousalDiff * arousalDiff)
        let featureScore = 1.0 - (featureDistance / sqrt(2.0)) // Normalize to [0, 1]
        
        // 2. User history score
        let historyScore = getUserHistoryScore(trackID: track.id, feedback: userFeedback)
        
        // 3. Diversity bonus (penalize very similar tracks to recent plays)
        // TODO: Implement once we have recent track history
        
        // 4. Weighted combination
        let finalScore = 0.7 * featureScore + 0.3 * historyScore
        
        return finalScore
    }
    
    /// Retrieves user's historical preference for a track
    private func getUserHistoryScore(trackID: String, feedback: [TrackFeedback]) -> Double {
        let trackFeedback = feedback.filter { $0.trackID == trackID }
        
        guard !trackFeedback.isEmpty else {
            return 0.5 // Neutral score for new tracks
        }
        
        // Aggregate feedback scores
        let totalScore = trackFeedback.reduce(0.0) { $0 + $1.score }
        let avgScore = totalScore / Double(trackFeedback.count)
        
        // Normalize from [-1, 1] to [0, 1]
        return (avgScore + 1.0) / 2.0
    }
    
    /// Applies gentle nudge toward positive valence (if settings enabled)
    private func applyMoodNudge(tracks: [Track], currentValence: Double) -> [Track] {
        // Only nudge if user is in low-valence state and has enabled nudges
        // currentValence is in -1.0 to 1.0 range (from mood coordinates)
        guard currentValence < 0.3 else {
            return tracks
        }
        
        // Identify tracks with slightly higher valence (within 0.2 range)
        // Normalize track valence from 0.0-1.0 to -1.0-1.0 for comparison
        let nudgeTracks = tracks.filter { track in
            let normalizedValence = track.features.normalizedValence
            return normalizedValence > currentValence &&
                   normalizedValence < currentValence + 0.25
        }
        
        guard !nudgeTracks.isEmpty else {
            return tracks
        }
        
        // Inject 1-2 nudge tracks into playlist (not at start)
        var finalPlaylist = tracks
        if let nudgeTrack = nudgeTracks.first {
            // Insert at position 3 (after user settles into playlist)
            if finalPlaylist.count > 3 {
                finalPlaylist.insert(nudgeTrack, at: 3)
            }
        }
        
        return finalPlaylist
    }
    
    // MARK: - Skip Pattern Detection
    
    /// Detects if user is experiencing frustration based on skip patterns
    /// - Parameter recentFeedback: Last 10 track interactions
    /// - Returns: True if silence mode should be triggered
    func shouldTriggerSilenceMode(recentFeedback: [TrackFeedback]) -> Bool {
        // Get last 10 actions
        let recent = Array(recentFeedback.suffix(10))
        
        // Count skips in last 5 minutes
        let fiveMinutesAgo = Date().addingTimeInterval(-300)
        let recentSkips = recent.filter {
            $0.action == .skip && $0.timestamp > fiveMinutesAgo
        }
        
        // Trigger if 4+ skips in 5 minutes
        return recentSkips.count >= 4
    }
    
    /// Analyzes skip patterns to adjust future recommendations
    /// - Parameter feedback: Recent user interactions
    /// - Returns: Adjustment vector (Δvalence, Δarousal)
    func analyzeSkipPatterns(feedback: [TrackFeedback]) -> (valence: Double, arousal: Double) {
        let recentSkips = feedback.filter { $0.action == .skip }.suffix(5)
        
        guard recentSkips.count >= 3 else {
            return (0.0, 0.0) // Not enough data
        }
        
        // Average the audio features of skipped tracks
        // Assumption: User wants opposite of what they skipped
        // (This is simplified; real implementation would be more nuanced)
        
        return (0.0, -0.1) // Placeholder: suggest lower energy
    }
    
    // MARK: - Content Filtering (Lyric Analysis)
    
    /// Flags tracks with potentially heavy lyrical content
    /// - Parameter track: Track to analyze
    /// - Returns: True if track should be deprioritized in vulnerable states
    func hasHeavyThemes(track: Track) -> Bool {
        // In production, this would:
        // 1. Fetch lyrics from Genius API or MusixMatch
        // 2. Run NLP to detect themes: violence, self-harm, hopelessness, loss
        // 3. Cache results locally
        
        // For now, use audio features as proxy
        // Low valence + low energy + minor key = potentially heavy
        let isLowValence = track.features.valence < 0.35
        let isLowEnergy = track.features.energy < 0.4
        let isAcoustic = track.features.acousticness > 0.5
        
        return isLowValence && isLowEnergy && isAcoustic
    }
    
    /// Filters playlist to deprioritize heavy content when user is vulnerable
    func filterHeavyContent(
        tracks: [Track],
        userState: (valence: Double, arousal: Double),
        enabled: Bool
    ) -> [Track] {
        guard enabled else { return tracks }
        
        // Only filter if user is in vulnerable state (low valence + low arousal)
        // userState is in -1.0 to 1.0 range (from mood coordinates)
        // Low valence = negative emotions (< 0.0), Low arousal = calm/low energy (< 0.0)
        let isVulnerable = userState.valence < 0.0 && userState.arousal < 0.0
        
        guard isVulnerable else { return tracks }
        
        // Separate heavy and safe tracks
        var heavyTracks: [Track] = []
        var safeTracks: [Track] = []
        
        for track in tracks {
            if hasHeavyThemes(track: track) {
                heavyTracks.append(track)
            } else {
                safeTracks.append(track)
            }
        }
        
        // Return safe tracks first, heavy tracks at end (still accessible)
        return safeTracks + heavyTracks
    }
    
    // MARK: - Model Setup
    
    private func setupSentimentAnalyzer() {
        // In production, load custom CoreML model here
        // For now, using built-in NaturalLanguage framework
    }
    
    // MARK: - Federated Learning (Future)
    
    /// Prepares model gradients for federated learning
    /// - Note: This would aggregate user feedback into model updates
    ///         without uploading raw data
    func prepareFederatedUpdate(feedback: [TrackFeedback]) -> Data? {
        // TODO: Implement federated learning protocol
        // 1. Compute local gradient updates
        // 2. Encrypt gradients
        // 3. Return for aggregation
        return nil
    }
}

