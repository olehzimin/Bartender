//
//  ProcetWheelView.swift
//  Bartender
//
//  Created by Oleh Zimin on 06.06.2025.
//

import SwiftUI

struct ProcentWheelView: View {
    var value: Int
    let maxValue: Int = 50
    private var valueProcent: Double {
        Double(value) / Double(maxValue)
    }
    private var duration: Double {
        sqrt(valueProcent)
    }
    
    @State private var wheelValue = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 12)
                .foregroundStyle(.gray)
            
            Circle()
                .trim(from: 0.0, to: wheelValue)
                .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                .foregroundStyle(.pink)
                .rotationEffect(Angle(degrees: 270))
                
            
            Text("\(value)%")
                .font(.bartenderTitle)
                .foregroundStyle(.pink)
        }
        .onAppear {
            Task {
                try await Task.sleep(for: .seconds(1))
                wheelValue = valueProcent
            }
        }
        .animation(.easeInOut(duration: duration), value: wheelValue)
    }
}

#Preview {
    ProcentWheelView(value: 35)
        .frame(width: 100, height: 100)
}
