//
//  Slide.swift
//  PinGame
//
//  Created by Bahattin Koç on 6.03.2022.
//

import Foundation

struct Slide {
    let imageTxt: String
    let title: String
    let detail: String
    
    static let slides = [
        Slide(imageTxt: "slide6", title: "Unbiased", detail: "We offer uncensored, unmanipulated information about games. We will never elevate our opinions, reviews or ratings over our users."),
        Slide(imageTxt: "slide7", title: "Video game professionals", detail: "The games you love are made by real people. We wish to elevate the status of game developers by showing them to you."),
        Slide(imageTxt: "slide6", title: "User focused", detail: "We cannot build the best game page in the world just by ourselves. We need our users to achieve that. PinGame.com is being built by actively listening to, and communicating with our audience."),
        Slide(imageTxt: "slide7", title: "Indie games", detail: "Indie developers do not have the same means of exposing their games with the world compared to AAA game studios.")
    ]
}
