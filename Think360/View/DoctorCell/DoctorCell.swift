//
//  DoctorCell.swift
//  Think360
//
//  Created by admin on 15/04/19.
//  Copyright © 2019 AcknoTech. All rights reserved.
//

import UIKit

class DoctorCell:UITableViewCell{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var cardView:UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .white
        return cardView
    }()
    
     lazy var profileImage:CustomImageView = {
        let profileimage = CustomImageView()
        profileimage.contentMode = .scaleAspectFill
        profileimage.backgroundColor = .gray
        profileimage.layer.cornerRadius = (contentView.frame.width/3)/2
        profileimage.translatesAutoresizingMaskIntoConstraints = false
        profileimage.clipsToBounds = true
        return profileimage
    }()
    
    private lazy var moreImage:UIImageView = {
        let moreImage = UIImageView()
        moreImage.contentMode = .scaleAspectFill
        moreImage.translatesAutoresizingMaskIntoConstraints = false
        return moreImage
    }()
    private lazy var videoImage:UIImageView = {
        let videoImage = UIImageView()
        videoImage.contentMode = .scaleAspectFill
        videoImage.translatesAutoresizingMaskIntoConstraints = false
        return videoImage
    }()
    
    private lazy var doctorName:UILabel = {
        let doctorName = UILabel()
        doctorName.textAlignment = .left
        doctorName.font = UIFont(name: "Avenir-Black", size: 18)
        doctorName.textColor = UIColor(red: 33/225, green: 33/225, blue: 33/225, alpha: 1)
        doctorName.translatesAutoresizingMaskIntoConstraints = false
        doctorName.numberOfLines = 0
        return doctorName
    }()
    
    private lazy var doctorDegree:UILabel = {
        let doctorDegree = UILabel()
        doctorDegree.textAlignment = .left
        doctorDegree.font = UIFont(name: "Avenir-Medium", size: 18)
        doctorDegree.textColor = UIColor(red: 145/225, green: 145/225, blue: 145/225, alpha: 1)
        doctorDegree.translatesAutoresizingMaskIntoConstraints = false
        doctorDegree.numberOfLines = 0
        return doctorDegree
    }()
    
    private lazy var doctorOfficeName:UILabel = {
        let doctorOfficeName = UILabel()
        doctorOfficeName.textAlignment = .left
        doctorOfficeName.font = UIFont(name: "Avenir-Black", size: 18)
        doctorOfficeName.textColor = UIColor(red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
        doctorOfficeName.translatesAutoresizingMaskIntoConstraints = false
        doctorOfficeName.numberOfLines = 0
        return doctorOfficeName
    }()
    
    private lazy var doctoraddress:UILabel = {
        let doctoraddress = UILabel()
        doctoraddress.textAlignment = .left
        doctoraddress.font = UIFont(name: "Avenir-Medium", size: 18)
        doctoraddress.textColor = UIColor(red: 4/255, green: 51/255, blue: 255/255, alpha: 1)
        doctoraddress.translatesAutoresizingMaskIntoConstraints = false
        doctoraddress.numberOfLines = 0
        return doctoraddress
    }()
    
    private lazy var doctorSpecialization:UILabel = {
        let doctorSpecialization = UILabel()
        doctorSpecialization.textAlignment = .left
        doctorSpecialization.font = UIFont(name: "Avenir-Medium", size: 18)
        doctorSpecialization.textColor = UIColor(red: 145/225, green: 145/225, blue: 145/225, alpha: 1)
        doctorSpecialization.translatesAutoresizingMaskIntoConstraints = false
        doctorSpecialization.numberOfLines = 0
        return doctorSpecialization
    }()
    
    private func setupViews(){
        addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
            ])
        cardView.addSubview(profileImage)
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            profileImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            profileImage.heightAnchor.constraint(equalToConstant: contentView.frame.width/3),
            profileImage.widthAnchor.constraint(equalToConstant: contentView.frame.width/3)
            ])
        
        
        let moreimageStack = stackViews(views: [moreImage])
        moreimageStack.alignment = .trailing
        
        let doctorDesc = stackViews(views: [doctorName,moreimageStack])
        doctorDesc.axis = .horizontal
        
        cardView.addSubview(doctorDesc)
        
        NSLayoutConstraint.activate([
            doctorDesc.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10),
            doctorDesc.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            doctorDesc.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20)
            ])
        
        NSLayoutConstraint.activate([
                        moreImage.widthAnchor.constraint(equalToConstant: 30),
                        moreImage.heightAnchor.constraint(equalToConstant: 30)
                        ])
        
        cardView.addSubview(doctorDegree)
        NSLayoutConstraint.activate([
            doctorDegree.topAnchor.constraint(equalTo: doctorDesc.bottomAnchor, constant: 10),
            doctorDegree.leadingAnchor.constraint(equalTo: doctorDesc.leadingAnchor, constant: 0),
            doctorDegree.widthAnchor.constraint(equalToConstant: 200)
            ])
        cardView.addSubview(doctorSpecialization)
        NSLayoutConstraint.activate([
            doctorSpecialization.topAnchor.constraint(equalTo: doctorDegree.bottomAnchor, constant: 10),
            doctorSpecialization.leadingAnchor.constraint(equalTo: doctorDesc.leadingAnchor, constant: 0),
            doctorSpecialization.widthAnchor.constraint(equalToConstant: 200)
            ])
        
        let doctorDetails = stackViews(views: [doctorOfficeName,doctoraddress])
        doctorDetails.axis = .vertical
        
        let imageStack = stackViews(views: [videoImage])
        imageStack.alignment = .trailing
        
        let mainStack = stackViews(views: [doctorDetails,imageStack])
        mainStack.axis = .horizontal
        
        cardView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: doctorSpecialization.bottomAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: doctorDesc.leadingAnchor, constant: 0),
            mainStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -10),
            mainStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10)
            ])
        
        
        NSLayoutConstraint.activate([
            videoImage.heightAnchor.constraint(equalToConstant: 45),
            videoImage.widthAnchor.constraint(equalToConstant: 45)
            ])
    }
    
    func loadDatainCell(doctorData:CellData){
        if doctorData.photo != ""{
            profileImage.loadImageUsingURLString(urlString: doctorData.photo)
        }else{
            profileImage.image = UIImage(named: "default")
            
        }
        doctorName.text = doctorData.fullname
        if !doctorData.degree.isEmpty{
            doctorDegree.text = doctorData.degree.joined(separator: ",")
        }
        if !doctorData.specialization.isEmpty{
            doctorSpecialization.text = "\(doctorData.specialization.joined(separator: ","))"
        }else{
            doctorDegree.text = ""
        }
        if doctorData.specialization.isEmpty && doctorData.degree.isEmpty{
            doctorDegree.text = "Not Mentioned"
        }
        if doctorData.officeName != ""{
            doctorOfficeName.text = doctorData.officeName
        }else{
            doctorOfficeName.text = "Not Mentioned"
        }
        
        if doctorData.city != "" && doctorData.stateCode != "" && doctorData.zip != ""{
            doctoraddress.text = "\(doctorData.city), \(doctorData.stateCode), \(doctorData.zip)"
        }else{
            doctoraddress.text = "Not Mentioned"
        }
        
        videoImage.image = UIImage(named: "Video")
        moreImage.image = UIImage(named: "More")
        
    }
}
