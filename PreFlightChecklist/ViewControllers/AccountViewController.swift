import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import ProgressHUD
import SPPermission

class AccountViewController: UIViewController {
    
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addPhotoBtn: UIButton!
    
    var avatar: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpElements()
    }
    
    private func setUpElements() {
        
        label.text = "Welcome, \(UserSettings.defaults.string(forKey: UserSettings.userName) ?? "")"
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        signOutBtn.layer.cornerRadius = signOutBtn.frame.height/2
        signOutBtn.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
    }
    
    private func saveAvatar() {
        
        guard let imageData = avatar?.jpegData(compressionQuality: 0.4) else { return }
        let storageRef = Storage.storage().reference(forURL: "gs://preflightchecklist-323e2.appspot.com")
        let storageProfileRef = storageRef.child("profile").child(Auth.auth().currentUser!.uid)
        UserSettings.setUserAvatarID(Auth.auth().currentUser!.uid)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageProfileRef.putData(imageData, metadata: metadata) { (storageMetaData, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            print(UserSettings.defaults.string(forKey: UserSettings.userAvatar)!)
        }
    }
    
    private func showAlert() {
        
        let alert = UIAlertController(title: "Image Selection", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { [ weak self ] (action: UIAlertAction) in
            self?.presentImagePicker(sourceType: .camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: { [ weak self ] (action: UIAlertAction) in
            self?.presentImagePicker(sourceType: .photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.allowsEditing = true
            picker.delegate = self
            present(picker, animated: true)
        }
    }
    
    @IBAction func signOutAction(_ sender: UIButton) {
        
        let alertVC = UIAlertController(title: "Sign out", message: "Are you sure?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
            ProgressHUD.show()
            UserSettings.goToFirstVC()
            ProgressHUD.dismiss()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertVC.addAction(yesAction)
        alertVC.addAction(noAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func addPhotoAction(_ sender: UIButton) {
        
        if SPPermission.isAllowed(.camera) && SPPermission.isAllowed(.photoLibrary) {
            showAlert()
        }
        else {
            SPPermission.Dialog.request(with: [.camera, .photoLibrary], on: self, delegate: self)
        }
    }
}

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, SPPermissionDialogDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        profileImage.image = selectedImage
        avatar = selectedImage
        saveAvatar()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func didHide() {
        
        if SPPermission.isAllowed(.photoLibrary) && SPPermission.isAllowed(.camera) {
            showAlert()
        }
    }
}
