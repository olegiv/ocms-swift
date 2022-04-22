//
//  MenuOcms.swift
//  
//
//  Created by Oleg Ivanchenko on 20.04.22.
//

import SwiftHtml

struct TopMenu {
    
    let menuItems = [
        [
            "title": "Homepage",
            "uri": "/",
            "with_auth": false
        ],
        [
            "title": "Download",
            "uri": "/download",
            "with_auth": false
        ],
        [
            "title": "Blog",
            "uri": "/blog",
            "with_auth": false
        ],
        [
            "title": "About",
            "uri": "/about",
            "with_auth": false
        ]
    ]
    
    func getHtml() -> String {
        
        var html = "";
        
        menuItems.forEach { menuItem in
            let doc = Document(.html) {
                Li {
                    A(menuItem["title"] as? String)
                        .href(menuItem["uri"] as! String)
                        .target(.parent)
                }
            }
            
            html = html + DocumentRenderer(minify: false, indent: 2).render(doc)
        }
        
        return html
    }
}
