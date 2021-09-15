//
//  RecordView.swift
//  FirebaseProfileSwiftUI
//
//  Created by rafiul hasan on 15/9/21.
//

import SwiftUI

struct RecordView: View {
    @ObservedObject var vm = VoiceViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Image(systemName: vm.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                    .foregroundColor(.red)
                    .font(.system(size: 45))
                    .onTapGesture {
                        if vm.isRecording == true {
                            vm.stopRecording()
                        } else {
                            vm.startRecording()
                        }
                    }
            }
            
            if vm.isRecording {
                VStack(alignment : .leading , spacing : -10){
                    HStack {
                        HStack (spacing : 3) {
                            Image(systemName: vm.isRecording && vm.toggleColor ? "circle.fill" : "circle")
                                .font(.system(size:16))
                                .foregroundColor(.red)
                            Text("Rec")
                        }
                        
                        Text(vm.timer)
                            .font(.system(size:16))
                            .foregroundColor(.black)
                    }
                }
                
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
            .preferredColorScheme(.dark)
    }
}
