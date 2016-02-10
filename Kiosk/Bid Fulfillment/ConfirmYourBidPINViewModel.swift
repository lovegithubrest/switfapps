import Foundation
import RxSwift

protocol ConfirmYourBidPINViewModelType {
    func checkForCCAdminBypass(bidDetails: BidDetails, authenticatedProvider: AuthorizedNetworking) -> Observable<(Bool, AuthorizedNetworking)>
}

class ConfirmYourBidPINViewModel: ConfirmYourBidPINViewModelType {
    func checkForCCAdminBypass(bidDetails: BidDetails, authenticatedProvider: AuthorizedNetworking) -> Observable<(Bool, AuthorizedNetworking)> {
        return authenticatedProvider
            .request(ArtsyAuthenticatedAPI.FindMyBidderRegistration(auctionID: bidDetails.auctionID))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .doOnNext({ (thing) -> Void in
                print(thing)
            })
            .doOnError({ (error) -> Void in
                print(error)
            })
            .mapReplace((true, authenticatedProvider))
    }
}