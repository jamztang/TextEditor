//
//  ViewController.swift
//  TextEditor
//
//  Created by James Tang on 19/6/2024.
//

import UIKit

struct Issue {
    enum Content {
        case html(String)
    }

    let title: String
    let content: Content

    // Mock Data
    static let typex1501: Issue = .init(
        title: "TYPEX-1501",
        content: .html("<span style='color: green'><b>Ipsum</b> world Ipsum world</span>")
    )
    static let typex1493: Issue = .init(
        title: "TYPEX-1493",
        content: .html("""
        <span style="color: green">
        <p style="text-indent: 0px;">ipsum world</p>
        <p style="text-indent: 15px;">world</p>
        <p style="text-indent: 30px;">world ipsum</p>
        <p style="text-indent: 45px;">world</p>
        </span>
        """)
    )
    static let typex1698: Issue = .init(
        title: "TYPEX-1698",
        content: .html("""
        <ol style="color: green">
            <li>one</li>
                <ol>
                    <li>two</li>
                </ol>
        </ol>
        """)
    )
}

extension Issue {
    func action(_ handler: @escaping UIActionHandler) -> UIAction {
        .init(title: title, handler: handler)
    }
}

extension Issue.Content {
    var attributedString: NSAttributedString? {
        switch self {
        case .html(let string):
            let data = Data(string.utf8)
            guard let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
                return nil
            }
            return attributedString
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var resetMenu: UIMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let issues = [
            Issue.typex1501,
            .typex1493,
            .typex1698
        ]

        let actions = issues.map { issue in
            return issue.action { [weak self] action in
                self?.handle(issue)
            }
        }

        resetButton.menu = UIMenu(title: "", children: actions)

    }

    func handle(_ issue: Issue) {
        textView.attributedText = issue.content.attributedString
    }
}
