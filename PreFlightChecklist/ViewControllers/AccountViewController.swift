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
        
        guard let localUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(UserSettings.defaults.string(forKey: UserSettings.currentUserUid)!) else { return }
        do {
            let imageData = try Data(contentsOf: localUrl)
            profileImage.image = UIImage(data: imageData)
        } catch {
            print("Error uploading image : \(error)")
        }
    }
    
    private func saveNewAvatar() {
        
        guard let imageData = profileImage.image?.jpegData(compressionQuality: 0.4) else { return }
        guard let localUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(UserSettings.defaults.string(forKey: UserSettings.currentUserUid)!) else { return }
        do {
            try imageData.write(to: localUrl)
        } catch {
            print(error.localizedDescription)
        }
        let storageRef = Storage.storage().reference(forURL: Constants.storageRef).child(UserSettings.defaults.string(forKey: UserSettings.currentUserUid)!)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.putData(imageData, metadata: metadata) { (storageMetaData, err) in
            if err != nil {
                print(err!.localizedDescription)
            }
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
            picker.delegate = self
            picker.sourceType = sourceType
            picker.allowsEditing = true
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
            SPPermission.Dialog.request(with: [.camera, .photoLibrary], on: self, delegate: self, dataSource: self)
        }
    }
}

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, SPPermissionDialogDelegate, SPPermissionDialogDataSource {
    
    var startTransitionYoffset: CGFloat {
        return 0
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        profileImage.image = selectedImage
        saveNewAvatar()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func didHide() {
        
        if SPPermission.isAllowed(.photoLibrary) && SPPermission.isAllowed(.camera) {
            showAlert()
        }
    }
}
