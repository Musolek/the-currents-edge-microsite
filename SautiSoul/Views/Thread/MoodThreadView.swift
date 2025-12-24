// MARK: - Mood Thread View
// Views/Thread/MoodThreadView.swift

import SwiftUI
import SwiftData

struct MoodThreadView: View {
    @Bindable var appState: AppState
    @Bindable var settings: AppSettings
    @Query private var moodEntries: [MoodEntry]
    
    var last7Moods: [MoodEntry] {
        Array(moodEntries.suffix(7))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#1a1a2e"), Color(hex: "#0f0f1e")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        appState.currentScreen = .home
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("Your Weather")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Color.clear
                        .frame(width: 44, height: 44)
                }
                .padding(.horizontal, 40)
                .padding(.top, 40)
                .padding(.bottom, 40)
                
                Spacer()
                
                Text("Your inner weather lately")
                    .font(.system(size: 18))
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.bottom, 40)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 24) {
                    ForEach(Array(last7Moods.enumerated()), id: \.element.id) { index, entry in
                        if let mood = entry.mood {
                            VStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(mood.gradient)
                                        .frame(width: 80, height: 80)
                                    
                                    Text(mood.icon)
                                        .font(.system(size: 40))
                                }
                                
                                Text(entry.timestamp, style: .date)
                                    .font(.system(size: 12))
                                    .foregroundColor(.white.opacity(0.6))
                                
                                if entry.journalText != nil {
                                    Image(systemName: "book")
                                        .foregroundColor(.white.opacity(0.4))
                                        .font(.system(size: 14))
                                }
                            }
                            .animation(.easeInOut(duration: 0.6).delay(Double(index) * 0.1), value: index)
                        }
                    }
                }
                .padding(.horizontal, 40)
                .frame(maxWidth: 600)
                
                Spacer()
            }
        }
    }
}

