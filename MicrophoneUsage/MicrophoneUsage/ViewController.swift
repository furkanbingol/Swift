//
//  ViewController.swift
//  MicrophoneUsage
//
//  Created by Furkan Bingöl on 16.04.2023.
//

import UIKit
import AVFoundation

/*
 "AVAudioSession" is there to enable and track sound recording as a whole,
 and "AVAudioRecorder" is there to track one individual recording.
 That is, the session is the bit that ensures we are able to record,
 the recorder is the bit that actual pulls data from the microphone and writes it to disk.
*/

class ViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var micButton: UIButton!
    private var recordingSession: AVAudioSession!
    private var whistleRecorder: AVAudioRecorder!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission { [unowned self] allowed in     // Also add Info.plist --> Privacy - Microphone Usage Description
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        self.loadFailUI()
                    }
                }
            }
        } catch {
            self.loadFailUI()
        }
    }
    
    
    // MARK: - Functions
    func loadRecordingUI() {
        micButton.setTitle("Tap to Record", for: .normal)
        micButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
    }

    func loadFailUI() {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = "Recording failed: please ensure the app has access to your microphone."
        failLabel.numberOfLines = 0
        failLabel.frame = CGRect(x: 50, y: 100, width: 200, height: 100)
        
        self.view.addSubview(failLabel)
    }
    
    
    @objc func recordTapped() {
        if whistleRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }

    
    func startRecording() {
        view.backgroundColor = UIColor.systemRed

        micButton.setTitle("Tap to Stop", for: .normal)

        let audioURL = ViewController.getWhistleURL()
        print(audioURL.absoluteString)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            whistleRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            whistleRecorder.delegate = self
            whistleRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        view.backgroundColor = UIColor.systemGreen

        whistleRecorder.stop()
        whistleRecorder = nil

        if success {
            micButton.setTitle("Success! Tap to Re-record", for: .normal)
        } else {
            micButton.setTitle("Fail! Tap to Record", for: .normal)

            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your whistle; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    // class func: You call them on the class not on instances of the class.
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    class func getWhistleURL() -> URL {
        return getDocumentsDirectory().appendingPathExtension("whistle.m4a")
    }
    
    
    // MARK: - Delegate Function
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag == false {
            finishRecording(success: false)
        }
    }
}

