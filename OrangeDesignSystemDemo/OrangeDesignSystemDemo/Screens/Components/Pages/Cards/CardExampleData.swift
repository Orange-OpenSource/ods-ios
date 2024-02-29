//
// Software Name: Orange Design System
// SPDX-FileCopyrightText: Copyright (c) Orange SA
// SPDX-License-Identifier: MIT
//
// This software is distributed under the MIT license,
// the text of which is available at https://opensource.org/license/MIT/
// or see the "LICENSE" file for more details.
//
// Authors: See CONTRIBUTORS.txt
// Software description: A SwiftUI components library with code examples for Orange Design System
//

import OrangeDesignSystem
import SwiftUI

#if USE_STATIC_TEXT
public let cardExampleTitle = "Title"
public let cardExampleSubtitle = "Subtitle"
public let cardExampleSupportingText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt."

public let cardExampleLongTitle = "Et galisum fugiat ex omnis officia et iusto eius et animi consequuntur et distinctio magnam id autem exercitationem a sint quibusdam. Aut ipsa autem aut omnis architecto ex ratione provident eum placeat atque qui veniam quos est rerum molestiae."

public let cardExampleLongSubtitle = "Sed quasi illo in quidem consectetur sit consequatur voluptatibus sed adipisci fuga quo voluptatem similique non quidem magni! Et dolores libero ut voluptatem possimus ea minus necessitatibus qui totam culpa vel maxime distinctio id ullam dolor et optio velit"

public let cardExampleLongSupportingText = "Lorem ipsum dolor sit amet. In similique soluta et corrupti aperiam et ipsum quibusdam aut ducimus beatae aut aliquid perferendis qui sunt quam et dolor maxime. Est laudantium quod sit nihil possimus et quas voluptatem in fugit deserunt sit Quis eligendi aut deserunt voluptatum est quia dolor. Quasi odit et incidunt quis sit quia inventore ut repellat quam hic repellat veritatis est dolorem quia et expedita voluptas. Et internos molestiae ut tempora quod non facere nisi ad doloribus velit ad enim corporis qui molestias dolorum qui galisum velit."

public let cardExampleImage: ODSImage.Source = .image(Image("placeholder", bundle: Bundle.ods))

#else
let recipeForCardExample = RecipeBook.shared.recipes[0]

public let cardExampleTitle = recipeForCardExample.title
public let cardExampleSubtitle = recipeForCardExample.subtitle
public let cardExampleSupportingText = recipeForCardExample.description
public let cardExampleLongTitle = "TO BE DEFINED"
public let cardExampleLongSubtitle = "TO BE DEFINED"
public let cardExampleLongSupportingText = "TO BE DEFINED"
public let cardExampleImage: ODSImage.Source = .asyncImage(recipeForCardExample.url, Image("placeholder", bundle: Bundle.ods))
#endif
