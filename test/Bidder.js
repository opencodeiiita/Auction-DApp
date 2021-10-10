const Bidder = artifacts.require("Bidder") ;

contract("Bidder" , () => {
    let bidder = null ;
    before(async () => {
        bidder = await Bidder.deployed() ;
    });

    it("Setting the Bidder - Positive" ,async () => {
        await bidder.setBidder("Mukesh Ambani" , 6000) ;
        const name = await bidder.bidderName() ;
        const amount = await bidder.bidAmount();
        const eligible = await bidder.displayEligibility() ;

        assert(name === "Mukesh Ambani");
        assert(amount.toNumber() === 6000);
        assert(eligible === true) ;
    });

    it("Setting the Bidder - Negative" ,async () => {
            await bidder.setBidder("Mukesh Ambani" , 4999) ;
            const name = await bidder.bidderName() ;
            const amount = await bidder.bidAmount();
            const eligible = await bidder.displayEligibility() ;

            assert(name === "Mukesh Ambani");
            assert(amount.toNumber() === 4999);
            assert(eligible === false) ;
        });
});