FactoryBot.define do

    factory :user do
        email           {"test@test.com"}
        password        {"Passw0rd1!"}
        name            {"user"}
        surname         {"test"}
        admin           {false}
    end

    factory :admin do
        email           {"admin@admin.com"}
        password        {"Passw0rd!"}
        name            {"admin"}
        surname         {"test"}
        admin           {true}
    end

    
end