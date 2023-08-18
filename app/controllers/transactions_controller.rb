class TransactionsController < ApplicationController


    def all_transactions
        byebug
        @transaction = Transaction.where(user_id: params[:user_id])
        @transaction.present?
        render json: @transaction
    end
end






