/*
	Copyright (C) 2016 Apple Inc. All Rights Reserved.
	See LICENSE.txt for this sample’s licensing information
	
	Abstract:
	Photo capture delegate.
*/

import AVFoundation
import Photos

class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    
	private(set) var requestedPhotoSettings: AVCapturePhotoSettings
	
	private let willCapturePhotoAnimation: () -> ()
	
	private let completed: (PhotoCaptureDelegate) -> ()
	
	private var photoData: Data? = nil
    
    private let delegateController: UIViewController?

	init(with controller: UIViewController, requestedPhotoSettings: AVCapturePhotoSettings, willCapturePhotoAnimation: @escaping () -> (), capturingLivePhoto: @escaping (Bool) -> (), completed: @escaping (PhotoCaptureDelegate) -> ()) {
		self.requestedPhotoSettings = requestedPhotoSettings
		self.willCapturePhotoAnimation = willCapturePhotoAnimation
		self.completed = completed
        self.delegateController = controller
	}
	
	private func didFinish() {
		completed(self)
	}
	
	func capture(_ captureOutput: AVCapturePhotoOutput, willCapturePhotoForResolvedSettings resolvedSettings: AVCaptureResolvedPhotoSettings) {
		willCapturePhotoAnimation()
	}
	
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
		if let photoSampleBuffer = photoSampleBuffer {
            photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer)
		}
		else {
			print("Error capturing photo: \(error)")
			return
		}
	}
	
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishCaptureForResolvedSettings resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
		if let error = error {
			print("Error capturing photo: \(error)")
			didFinish()
			return
		}
		
		guard let photoData = photoData else {
			print("No photo data resource")
			didFinish()
			return
		}
        
        let convertedImage = UIImage.init(data: photoData)
        let flipedImage = UIImage.init(cgImage: (convertedImage?.cgImage!)!, scale: (convertedImage?.scale)!, orientation: .leftMirrored)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PSDPreviewViewController") as! PSDPreviewViewController
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        controller.previewImage = flipedImage
        self.delegateController?.present(controller, animated: false, completion: nil)
        
//        let doublFlipedImage = UIImage.init(cgImage: (convertedImage?.cgImage!)!, scale: (convertedImage?.scale)!, orientation: .rightMirrored)
//        let convertedData = UIImageJPEGRepresentation(doublFlipedImage, 1)
//        
//		PHPhotoLibrary.requestAuthorization { [unowned self] status in
//			if status == .authorized {
//				PHPhotoLibrary.shared().performChanges({
//                    let creationRequest = PHAssetCreationRequest.forAsset()
//						creationRequest.addResource(with: .photo, data: convertedData!, options: nil)
//					
//                    }, completionHandler: { [unowned self] success, error in
//						if let error = error {
//							print("Error occurered while saving photo to photo library: \(error)")
//						}
//						
//						self.didFinish()
//					}
//				)
//			}
//			else {
//				self.didFinish()
//			}
//		}
	}
}
