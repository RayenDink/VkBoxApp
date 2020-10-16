//
//  PageViewController.swift
//  VK Client
//
//  Created by Rayen D on 06.09.2020.
//  Copyright © 2020 Rayen D. All rights reserved.
//

import UIKit
import RealmSwift

class PageViewController: UIPageViewController {
    
    var imagesUser = [User]()
    var imagesName = [String]()
    var titleItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        setupSliderView()
        
        fetchRequestPhotosUser(for: ownerID)
        
    }
    func fetchRequestPhotosUser(for id: Int?) {
        realmManager.updatePhotos(for: id)
        do {
            let realm = try Realm()
            do {
                         let realm = try Realm()
            let photo = realm.objects(Photo.self)
                imagesUser = Array(photo)

                         } catch {
                            print(error)}
            DispatchQueue.main.async { [weak self] in

                        self?.setupView()
                   }

                    self.setupSliderView()
            
            friendsImage = Array(photo).first
            
        } catch {
            
            print(error)
            setupNavigationBar()
        }
        
        func showViewControllerAtIndex(_ index: Int) -> ImagesFriendController? {
            
            guard index >= 0, index < imagesName.count,
                  let imagesFriendController = storyboard?.instantiateViewController(withIdentifier: "ImagesFriendController") as? ImagesFriendController
            else { return nil }
            guard let url = imagesSize[index].src,

                            let imageURL = URL(string: url),
                            let imageData = try? Data(contentsOf: imageURL) else { return nil }
            DispatchQueue.main.async {
                magesFriendController.imagesFriend.image = UIImage(data: imageData)

                              imagesFriendController.view.reloadInputViews()
            
            imagesFriendController.images = UIImage(named: imagesName[index])
            imagesFriendController.currentPage = index
            imagesFriendController.numberOfPages = imagesName.count
            
            return imagesFriendController
        }
        
        private func setupSliderView() {
            
            for (_,imageName) in imagesUser.enumerated() {
                imagesName.append(contentsOf: imageName.imageFriend)
            }
        }
        
        private func setupNavigationBar() {
            
            if let topItem = navigationController?.navigationBar.topItem {
                
                topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            }
            
            guard titleItem != nil else { return }
            title = titleItem
        }
        
        
        extension PageViewController: UIPageViewControllerDataSource {
            
            // Переход назад
            func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
                
                var pageNumber = (viewController as! ImagesFriendController).currentPage
                pageNumber -= 1
                
                return showViewControllerAtIndex(pageNumber)
            }
            
            // Переход вперед
            func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
                
                var pageNumber = (viewController as! ImagesFriendController).currentPage
                pageNumber += 1
                
                return showViewControllerAtIndex(pageNumber)
            }
        }
