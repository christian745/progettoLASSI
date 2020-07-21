FactoryBot.define do

    factory :user1, class: User do
        email           {"test1@test.com"}
        password        {"Passw0rd1!"}
        name            {"user1"}
        surname         {"test1"}
        admin           {false}
    end

    factory :user2, class: User do
        email           {"test2@test.com"}
        password        {"Passw0rd2!"}
        name            {"user2"}
        surname         {"test2"}
        admin           {false}
    end

    factory :user3, class: User do
        email           {"test3@test.com"}
        password        {"Passw0rd3!"}
        name            {"user3"}
        surname         {"test3"}
        admin           {false}
    end

    factory :admin, class: User do
        email           {"admin@admin.com"}
        password        {"Passw0rd!"}
        name            {"admin"}
        surname         {"test"}
        admin           {true}
    end

    factory :schedule do
        tipo           {"tipo"}
        muscoli        {"muscoli"}
        descrizione    {"descrizione"}
        user           {FactoryBot.create(:user2)}
    end

    factory :comment do
        body            {"testo di prova"}
        user            {FactoryBot.create(:user3)}
        schedule        {FactoryBot.create(:schedule)}
    end

end