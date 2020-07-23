Feature: Admin can delete a user

    As an admin
    I want to click on the delete button
    so that I can remove a user
    
    Scenario: admin deletes a user

        Given a valid admin
        
        When I am on the home page
        And I follow "Login"
        Then I should be on the Login page

        When I fill in "user_email" with "admin@admin.com"
        And I fill in "user_password" with "admin123"
        And I press "Login tramite email"
        Then I should be on the home page

        Given a user
        
        When I follow "Lista profili"
        Then I should be on the Profiles page

        When I follow "Vedi dettagli"
        Then I should be on the Profile Details page

        When I follow "Rimuovi profilo"
        Then I should be on the Profiles page
        And I should not see User email


