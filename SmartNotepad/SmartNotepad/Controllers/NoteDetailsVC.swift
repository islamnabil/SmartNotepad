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
    
    fileprivate func setNoteDetails(){
        noteTitleTextField.text = note?.title
        noteBodyTextView.text = note?.body
        if note?.locationAddress != "" {
            setAddress(address: note?.locationAddress ?? "")
        }
        if note?.image != "" {
            setNoteImage(imageName: note?.image ?? "")
        }
    }
    
    fileprivate func setAddress(address:String){
        addLocationButton.setTitle(address, for: .normal)
        addLocationButton.setTitleColor(.black, for: .normal)
    }
    
    fileprivate func setNoteImage(imageName:String){
        let image =  UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 60, y: 10, width: 200, height: 100)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.cornerRadius = 5
        addPhotoView.addSubview(imageView)
    }
    
    // MARK: - ShowActionSheet
    func showEnableLocationServices() {
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
