class AccountsController < ApplicationController

    def create
        byebug
        @account = Account.new(account_params)
        if @account.save
            render json: @account, status: :created
        else
            render json: @account.errors, status: :unprecessable_entity
        end
    end

    




  private

    def account_params
        params.require(:account).permit(:user_id, :account_number)
    end

end
