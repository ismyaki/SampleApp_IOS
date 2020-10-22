//
//  ViewController.swift
//  SampleApp
//
//  Created by Aki Wang on 2020/10/21.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        syncApi()
    }
    
    private func syncApi(){
        DispatchQueue(label: "api").async {
            // Sync api start
            if let error = self.getApiTapieiYouBike() {
                DispatchQueue.main.async {
                    self.showTextAlert(message: self.decodeError(error)) {
                        // clean data
                    }
                }
            }
            // Sync api finish, go to TabBarController or LoginViewController ...
            DispatchQueue.main.async {
                self.dismiss(animated: false)
                if UserDefaultsManager.getInstance().isLogin() {
                    let storyboard = UIStoryboard.init(name: "Tab", bundle: nil)
                    if let next = storyboard.instantiateViewController(withClass: TabBarController.self) {
                        next.modalPresentationStyle = .fullScreen
                        self.present(next, animated: false)
                    }
                } else {
                    let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
                    if let next = storyboard.instantiateViewController(withClass: LoginViewController.self) {
                        next.modalPresentationStyle = .fullScreen
                        self.present(next, animated: false)
                    }
                }
            }
        }
    }
    
    private func getApiTapieiYouBike() -> ApiError?{
        let response = ApiService.getTapieiYouBikeStation()
        if response.isSuccess {
            let dao = BikeStationManager.getInstance()
            let _ = dao.insert(dict: response.data?.retVal ?? [:])
            dao.save()
        }
        return response.error
    }
    
    private func decodeError(_ error: ApiError) -> String{
        var result = ""
        if let message = error.errorJson["message"] as? String {
            result = message
        }
        if let errors = error.errorJson["errors"] as? Dictionary<String, Any> {
            for key in errors.keys {
                if let message = errors[key] as? [String] {
                    for str in message {
                        result.append(str.capitalizingFirstLetter())
                    }
                }
            }
        }
        return result
    }
    
    private func showTextAlert(message: String, closure:@escaping ()->()){
        let alertVc = AlertTextViewController.loadFromNib()
        //
        alertVc.messageString = message
        alertVc.onViewDidLoad = {
            alertVc.btnLeft.isHidden = true
        }
        alertVc.onClickRight = {
            alertVc.dismiss(animated: true, completion: {
                closure()
            })
        }
        alertVc.onClickLeft = {
            alertVc.dismiss(animated: true, completion: nil)
        }
        self.present(alertVc, animated: true, completion: nil)
    }
}

