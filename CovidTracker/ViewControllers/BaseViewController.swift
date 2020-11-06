//
//  BaseViewController.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/11/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var coordinator: MainCoordinator?
}

// MARK: - Storyboarded
extension BaseViewController: Storyboarded {}

protocol MVVMViewControllerProtocol: class {
    associatedtype T
    init(viewModel: T)
}

class BaseViewController2<U>: UIViewController, MVVMViewControllerProtocol {
    typealias T = U
    let viewModel: T
    
    var coordinator: MainCoordinator?
    
    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not implemented")
    }
}

#if DEBUG
import UIKit
import SwiftUI

struct DebugPreviewView<T: UIView>: UIViewRepresentable {
    let view: UIView
    
    init(_ builder: @escaping () -> T) {
        view = builder()
    }
    
    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> UIView {
        return view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        // To fit the view to the smallest possible size
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}

struct DebugPreviewViewController<View: UIViewController>: UIViewControllerRepresentable {
    let viewController: View
    
    init(_ builder: @escaping () -> View) {
        viewController = builder()
    }
    
    // MARK: - UIViewRepresentable
    func makeUIViewController(context: Context) -> View {
        return viewController
        
    }
    func updateUIViewController(_ uiViewController: View, context: UIViewControllerRepresentableContext<DebugPreviewViewController<View>>) {
        
    }
}
#endif
