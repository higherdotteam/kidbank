# kidbank
a pretend bank for kids and their parents, teaches kids about money and banking

Lets build a version of chase.com but make it a bank for kids. The idea is kids age 4-12 are not legally allowed to get a true bank account at a bank like chase. But they need a practice bank. A my-first-bank toy bank account that's not real, but teaches them about how to be a bank customer.  The biz model is you give this very modern great kid bank software and atm cards away for free, and make your money when your kids turn 13 and can get a legal account.
i.e. KidBank has a real GrownupBank as part of the same company. KidBank is a loss leader to get customers for GrownupBank.  So we a building a real bank bank, but we only have to build the kid part first. There are no regulations, no legal bank requirements because this isn't real money. Kids get playmoney in the accounts not dollars
But that doesn't mean the kids don't get a working atm card that works only at KidBank branches, and the little 4 or 5 year old that gets his first KidBank card is SO proud and SO excited. They stay a KidBank customer thru age 6,7,8,9 etc. Then when they are an adult, why goto bank of america or chase? Why not just stay with KidBank? It's a long con. You are gonna be THE bank but it'll take years for a new generation to grow into it.

https://higher.team/blog/2017/february/kidbank-augmented-reality-mobile-kid-bank-app

https://kidbank.team

https://higher.team

![](http://kidbank.team/images/atmv.png)

![](http://kidbank.team/images/mall.jpg)

![](http://kidbank.team/images/mall2.jpg)

xcodebuild -project "*path/fileName*.xcodeproj" -target "*targetName*" -sdk "*targetSDK*" -configuration *buildConfig* CODE_SIGN_IDENTITY="*NameOfCertificateIdentity*" PROVISIONING_PROFILE="*ProvisioningProfileName" OTHER_CODE_SIGN_FLAGS="--keychain *keyChainName*"

xcodebuild -project <ProjectName.xcodeproj> 
    -scheme <ProjectName> -sdk iphonesimulator 
    -configuration Debug 
    -destination "platform=iOS Simulator,name=<Device>,OS=9.3" 
    clean build

xcodebuild -exportArchive -exportFormat ipa \
    -archivePath "/Users/username/Desktop/MyiOSApp.xcarchive" \
    -exportPath "/Users/username/Desktop/MyiOSApp.ipa" \
    -exportProvisioningProfile "MyCompany Distribution Profile"

didFailToFindLocationAfter
2017-02-28 00:47:58.211200 kidbank[1975:1068018] [LogMessageLogging] 6.1 Unable to retrieve CarrierName. CTError: domain-2, code-5, errStr:((os/kern) failure)
2017-02-28 00:47:58.232256 kidbank[1975:1067868] Optional(<MKMapView: 0x100c3b7f0; frame = (0 0; 375 667); clipsToBounds = YES; autoresize = RM+BM; layer = <CALayer: 0x17003a3c0>>)
fatal error: unexpectedly found nil while unwrapping an Optional value
2017-02-28 00:48:02.737087 kidbank[1975:1068021] fatal error: unexpectedly found nil while unwrapping an Optional value

xcodebuild -exportArchive -archivePath "/Users/aa/Library/Developer/Xcode/Archives/2017-02-27/x1" -exportPath ~/KidBank.ipa  -exportOptionsPlist iOS/KidBank/Export.plist 
