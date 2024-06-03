import ballerina/http;

type CreditCardInfo record {
    string cardNumber;
    string cardHolder;
    string expiryDate;
    string cvv;
};

map<CreditCardInfo> creditCardStore = {};

# A service to represent a simple credit card adding and listing service.
# bound to port `9090`.
service /api/v1/card\-service on new http:Listener(9089) {

    # A resource function to list existing credit cards.
    # + return - Returns a list of credit card information.
    resource function get credit\-cards() returns CreditCardInfo[]|error {
        return creditCardStore.reduce(function (CreditCardInfo[] acc, CreditCardInfo creditCard) returns CreditCardInfo[] {
            acc.push(creditCard);
            return acc;
        }, []);
    }

    # A resource function to add a new credit card.
    # + creditCard - Credit card information to be added.
    # + return - Returns the added credit card information.
    resource function post credit\-cards(CreditCardInfo creditCard) returns CreditCardInfo|error {
        creditCardStore[creditCard.cardNumber] = creditCard;
        return creditCard;
    }
}
