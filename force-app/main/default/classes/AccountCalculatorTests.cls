@isTest
private class AccountCalculatorTests {
	@testSetup
    static void setupTestData(){
        Account a = new Account();
        a.Name = 'test';
        a.Industry = 'Manufacturing';
        insert a;
        
        Opportunity o = new Opportunity();
        o.AccountId = a.Id;
        o.Name = 'test';
        o.Amount = 0;
        o.StageName = 'Prospecting';
        o.CloseDate = system.today().addDays(30);
        insert o;
    }
    
    @isTest
    static void CalulateUnitTest(){
		List<Account> accounts = [
            SELECT Id FROM Account
        ];
        test.startTest();
	        AccountCalculator.Calculate(accounts);
        test.stopTest();
    }
}