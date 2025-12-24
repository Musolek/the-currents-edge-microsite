// MARK: - Onboarding View
// Views/Onboarding/OnboardingView.swift

import SwiftUI

struct OnboardingView: View {
    @Bindable var appState: AppState
    @Bindable var settings: AppSettings
    @State private var currentStep = 0
    
    private let steps = [
        OnboardingStep(
            title: "Welcome to Sauti Soul",
            subtitle: "Music that listens.",
            icon: "✨",
            description: "Sauti Soul recommends music based on how you feel. Your moods stay private. Always."
        ),
        OnboardingStep(
            title: "Premium from Day One",
            subtitle: "Free for now. Worth paying for.",
            icon: "🎵",
            description: "No ads. No data selling. No games. Just thoughtful recommendations built on respect."
        ),
        OnboardingStep(
            title: "Your Inner Weather",
            subtitle: "Select how you feel. Get a playlist.",
            icon: "☀️",
            description: "Skip what doesn't fit. We learn. Context tags, mood threads, and mixtapes unlock as you listen."
        )
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#1a1a2e"), Color(hex: "#0f0f1e")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                Text(steps[currentStep].icon)
                    .font(.system(size: 80))
                    .padding(.bottom, 40)
                
                VStack(spacing: 12) {
                    Text(steps[currentStep].title)
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text(steps[currentStep].subtitle)
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.bottom, 24)
                    
                    Text(steps[currentStep].description)
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
                
                // Step indicators
                HStack(spacing: 8) {
                    ForEach(0..<steps.count, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(index == currentStep ? Color.white : Color.white.opacity(0.3))
                            .frame(width: index == currentStep ? 32 : 8, height: 8)
                            .animation(.easeInOut, value: currentStep)
                    }
                }
                .padding(.bottom, 40)
                
                Button(action: {
                    if currentStep < steps.count - 1 {
                        withAnimation {
                            currentStep += 1
                        }
                    } else {
                        settings.hasCompletedOnboarding = true
                        appState.currentScreen = .home
                    }
                }) {
                    Text(currentStep < steps.count - 1 ? "Continue" : "Let's Start")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .cornerRadius(24)
                }
                .padding(.horizontal, 48)
                .padding(.bottom, 60)
            }
        }
    }
}

struct OnboardingStep {
    let title: String
    let subtitle: String
    let icon: String
    let description: String
}

