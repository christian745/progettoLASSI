Feature: Admin can delete a user

    Scenario: admin deletes a user

        Given a valid admin
        
        When I am on the home page
        And I press 'Login'
        Then I should be on Login page

        When I fill in "email" with "admin@admin.com"
        And I fill in "password" with "admin123"
        And I press "Login"
        Then I should be on the home page

        When I follow "Lista Profili"

        Given a user

        When I follow "Vedi dettagi"
        Then I should be on Profile Details page

        And I press "Rimuovi profilo"
        Then I should be on Lista Profili page
        And I should not see user email
