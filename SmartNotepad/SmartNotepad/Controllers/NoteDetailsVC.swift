//
//  NoteDetailsVC.swift
//  SmartNotepad
//
//  Created by Islam Elgaafary on 23/04/2021.
//

import UIKit
import CoreLocation

class NoteDetailsVC: UIViewController {
    // MARK: - Properties
    fileprivate var note:NoteModel?
    fileprivate var locationManager = CLLocationManager()
    
    // MARK: - IBOutlets
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteBodyTextView: UITextView!
    @IBOutlet weak var addPhotoViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var addPhotoView: UIView!
    @IBOutlet weak var addLocationButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // MARK: - Private Methods
    fileprivate func setupViews(){
        noteBodyTextView.delegate = self
        noteBodyTextView.textColor = UIColor.lightGray
        noteTitleTextField.attributedPlaceholder = NSAttributedString(string: "Note Title Here",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        if note != nil {
            setNoteDetails()
        }
    }
    
    fileprivate func setNoteDetails(){
        noteTitleTextField.text = note?.title
        noteBodyTextView.text = note?.body
        if note?.locationAddress != "" {
            setAddress(address: note?.locationAddress ?? "")
        }
        if note?.image != "" {
            setNoteImage(imageName: URL(string: note?.image ?? "")!)
        }
    }
    
    fileprivate func setAddress(address:String){
        addLocationButton.setTitle(address, for: .normal)
        addLocationButton.setTitleColor(.black, for: .normal)
    }
    
    fileprivate func setNoteImage(imageName:URL){
        let image = loadImage(fileURL: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 60, y: 10, width: 200, height: 100)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.cornerRadius = 5
        addPhotoView.addSubview(imageView)
    }
    
    fileprivate func setupLocation(){
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            switch locationManager.authorizationStatus {
            case .restricted, .denied:
                showEnableLocationServices()
            case .authorizedAlways, .authorizedWhenInUse, .notDetermined:
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            @unknown default:
                break
            }
        }
    }
    
    
    // MARK: - showEnableLocationServices
    fileprivate func showEnableLocationServices() {
        let alert = UIAlertController(title: "", message: "Enable location Services ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                     return
                }
                 if UIApplication.shared.canOpenURL(settingsUrl) {
                     UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                  }
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: false, completion: nil)
    }
    
    
    // MARK: - Public Methods
    func setData(note:NoteModel){
        self.note = note
    }
    
    // MARK: - IBActions
    @IBAction func saveNote(_ sender: Any) {
        
    }
    
    @IBAction func addLocation(_ sender: Any) {
        setupLocation()
    }
    
    @IBAction func addPhoto(_ sender: Any) {
        self.showAlert()
    }
    
}

// MARK: - UITextViewDelegate
extension NoteDetailsVC:UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Note Body Here"
            textView.textColor = UIColor.lightGray
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension NoteDetailsVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            CLGeocoder().reverseGeocodeLocation(manager.location ?? CLLocation()) { (placemarks, err) in
                if placemarks?.count ?? 0 > 0 {
                    self.setAddress(address: "\(placemarks?[0].locality ?? ""), \(placemarks?[0].country ?? "")")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.setAddress(address: "Failed to fetch address")
    }
    
}

//MARK:- Image Picker
extension NoteDetailsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Show alert to selected the media source type.
    private func showAlert() {

        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {

        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {

            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }

    //MARK:- UIImagePickerViewDelegate.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
               let imgName = imgUrl.lastPathComponent
               let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
               let localPath = documentDirectory?.appending(imgName)

            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            let data = image.pngData()! as NSData
               data.write(toFile: localPath!, atomically: true)
               let photoURL = URL.init(fileURLWithPath: localPath!)
               print(photoURL)
            self.setNoteImage(imageName: photoURL)
           }
        picker.dismiss(animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func loadImage(fileURL: URL) -> UIImage? {
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }


}
