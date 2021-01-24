 
//  PhotoViewmodel.swift
//  JSONPlaceholderDemo
//
//  Created by ko on 2021/1/23.
//

import RxSwift
import Moya
import Moya_ObjectMapper

class PhotoViewmodel {
    
    public let photoModel:PublishSubject<[PhotoModel]> = PublishSubject.init()
    public var keywords:PublishSubject<String> = PublishSubject.init() //for searchbarcontroller
    private let provider = MoyaProvider<NetworkManager>()
    private let disposeBag = DisposeBag()
    
    init() {
        
        self.provider.rx
            .request(.searcPhoto(keywrod: APPURL.Jsonplaceholder))
            .mapArray(PhotoModel.self)
            .subscribe(onSuccess: { [weak self] photos in
                
                
                self?.keywords.asDriver(onErrorJustReturn: "").startWith("1")
                    .drive(onNext: { [weak self] string in
                        
                        let resultPhoto = photos.filter {
                            ($0.title.lowercased().contains(string.lowercased()))
                        }
                        
                        self!.photoModel.onNext(resultPhoto.count < 1 ? photos : resultPhoto)
                    })
                    .disposed(by: (self?.disposeBag)!)
                
            }, onError: { error in
                print(error)
                self.photoModel.onNext([])
            })
            .disposed(by: self.disposeBag)
        
    }
}

