Feature: User can add a comment to a schedule

    As a user
    I want to write a comment
    so that I can publish my comment on the schedule's page

    Scenario: User adds a comment
    
        Given a user
        Given a schedule

        Given a second user
        
        When I am on the home page
        And I follow "Login"
        Then I should be on the Login page

        When I fill in "user_email" with "second@user.com"
        And I fill in "user_password" with "user12345"
        And I press "Login tramite email"
        Then I should be on the home page
        

        When I follow "Vedi scheda"
        Then I should be on the Schedule Details page

        When I fill in "comment_body" with "Commento di prova"
        And I press "Aggiungi"
        Then I should be on the Schedule Details page

        And I should see "Commento di prova"


