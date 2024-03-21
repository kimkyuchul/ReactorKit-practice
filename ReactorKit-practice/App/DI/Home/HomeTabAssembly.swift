//
//  HomeTabAssembly.swift
//  ReactorKit-practice
//
//  Created by Kooky macBook Air on 3/11/24.
//

import Swinject

struct HomeTabAssembly: Assembly {
    func assemble(container: Container) {
        let assemblys: [Assembly] = [
            HomeAssembly(),
            SecondAssembly(),
            ThirdAssembly()
        ]
        assemblys.forEach { $0.assemble(container: container) }
    }
}
