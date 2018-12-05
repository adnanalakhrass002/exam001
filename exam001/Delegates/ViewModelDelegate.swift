//
//  ViewModelDelegate.swift
//  exam001
//
//  Created by Seif Ghotouk on 11/12/18.
//  Copyright © 2018 Adnan Al-Akhrass. All rights reserved.
//

protocol ViewModelDelegate: class {
    func didUpdateData()
    func didAddData(_ index: Int)
}
