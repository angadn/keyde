# Keyde
A simple Keyboard Management Delegate for iOS 8+

Usage
-----

    class MyController: UIViewController {
	    @IBOutlet var rootView: UIView! // View to push up when keyboard shows up
	    
	    private var keyboardManagement: KeyboardManagementDelegate?

		override func viewDidLoad() {
			super.viewDidLoad()
			keyboardManagement = KeyboardManagementDelegate(targetView: rootView)
		}

		override func viewWillAppear(animated: Bool) {
			keyboardManagement!.viewWillAppear(animated)
		}

		override func viewWillDisappear(animated: Bool) {
			keyboardManagement!.viewWillDisappear(animated)
		}
	
		/* Call upon tapping a view or gesture, to shut the keyboard */
		@objc func ensureKeyboardShut() {
			keyboardManagement!.ensureKeyboardShut()
		}




