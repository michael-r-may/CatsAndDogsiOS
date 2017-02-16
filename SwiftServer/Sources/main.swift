//
//  main.swift
//  SwiftServer
//
//  Created by Developer on 2017/02/16.
//  Copyright © 2017 Michael May. All rights reserved.
//

import Vapor

let drop = Droplet()

drop.get("/hello") { _ in
    return "Hello Vapor"
}

drop.run()

