class PredefinedAccountTypeManager {
    private let appConfigProvider: IAppConfigProvider
    private let accountManager: IAccountManager
    private let accountCreator: IAccountCreator

    init(appConfigProvider: IAppConfigProvider, accountManager: IAccountManager, accountCreator: IAccountCreator) {
        self.appConfigProvider = appConfigProvider
        self.accountManager = accountManager
        self.accountCreator = accountCreator
    }

}

extension PredefinedAccountTypeManager: IPredefinedAccountTypeManager {

    var allTypes: [IPredefinedAccountType] {
        return appConfigProvider.predefinedAccountTypes
    }

    func account(predefinedAccountType: IPredefinedAccountType) -> Account? {
        return accountManager.accounts.first { predefinedAccountType.supports(accountType: $0.type) }
    }

    func createAccount(predefinedAccountType: IPredefinedAccountType) throws {
        _ = try accountCreator.createNewAccount(defaultAccountType: predefinedAccountType.defaultAccountType, createDefaultWallets: true)
    }

    func createAllAccounts() {
        for predefinedAccountType in allTypes {
            try? createAccount(predefinedAccountType: predefinedAccountType)
        }
    }

}
