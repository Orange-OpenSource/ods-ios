//
//  File.swift
//  
//
//  Created by Ludovic PINEL on 19/06/2023.
//

import SwiftUI
import OrangeDesignSystem


struct AboutModule: View {
    var body: some View {
        AboutSetup()
    }
}


let appInfo = ODSAboutApplicationInformation(name: "Orange Design System",
                                            version: "0.14.0",
                                            buildNumber: "123456",
                                            description: "Add here a short description of the application. Over 2 lines use « more ».",
                                             shareUrl: URL(string: "https://www.google.fr")!,
                                             feedbackUrl: URL(string: "https://www.google.fr")!)

struct AboutSetup: View {
    @State var showDemo: Bool = false
    @State var numberOfLinks: Int = 0

    var body: some View {
        ScrollView {
            ThemeProvider().imageFromResources("AboutImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(true)

            VStack(alignment: .leading) {
                Text("An « About » screen should be displayed in all Orange applications to show the application name, software version as wall as all legal data protection,privacy, terms of service and accessibility statement.")
                    .frame(width: .infinity)
                        
                
                Text("Customise the module")
                    .odsFont(.headline)
                    .padding(.top, ODSSpacing.m)
                    .padding(.bottom, ODSSpacing.s)
                
                Text("Some items such as : illustration (customizable), app name, privacy policy, terms of service and accessibility statement are mandatory.\nTo this standard screen you can add optional components :")
                
                Stepper("Additional link(s): \(numberOfLinks)",
                        value: $numberOfLinks,
                        in: 0 ... 4)
                    .padding(.vertical, ODSSpacing.m)
                
                NavigationLink(isActive: $showDemo) {
                    ODSAboutModule(headerIllustration:             ThemeProvider().imageFromResources("AboutImage"),
                                   applicationInformation: appInfo)
                } label: {
                    ODSButton(text: "View demo", emphasis: .highest, variableWidth: false) {
                        showDemo.toggle()
                    }
                }
            }
            .padding(.all, ODSSpacing.m)
        }
    }
}


#if DEBUG
struct ODSBanner_Previews: PreviewProvider {
    
    static var previews: some View {
        AboutSetup()
    }
}
#endif
