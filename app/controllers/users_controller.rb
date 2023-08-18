class UsersController < ApplicationController


    def index
        byebug
        @user = User.find_by(id: params[:user_id])
        @user.present?
        @user_name = @user.name
        render json: "user_name is #{@user_name}"
       

    end


    def create
        byebug
        @user = User.new(user_params)
        if @user.save
            render json: @user 
        else
            render json: @user.errors
        end
    end

   def deposite
    byebug
    @deposite = params[:deposite]
    @user = User.find_by(id: params[:user_id])
    if @user.present?
            @amount = @user.amount
            @pin = @user.pin
            if @pin == params[:pin].to_i 
            @d_amount = @amount+@deposite.to_i
             @user.update(amount: @d_amount)
             @t = Transaction.create(user_id: @user.id , t_amount: @deposite, transaction_type: "deposite")
            render json: "you  account is credited  with $#{@deposite} and updated balance is $#{@d_amount} and $#{@t}"
            else
                render json: "you have entered wrong pin!!!!."
            end
    end
   end

    def withdraw
        byebug
        @withdraw_money = params[:withdraw]
        @user = User.find_by(id: params[:user_id])
        if @user.present?
            @amount = @user.amount
            @pin = @user.pin
            if @pin == params[:pin].to_i
                if @amount > @withdraw_money.to_i
                    @w_amount = @amount-@withdraw_money.to_i
                    @user.update(amount: @w_amount)
                    @t = Transaction.create(user_id: @user.id , t_amount: @withdraw_money, transaction_type: "withdraw")

                    render json: "your account is debited with $#{@withdraw_money} updated balance is $#{@w_amount}"
                else
                    render json: "you have insufficient balance!!!."
                end
           else 
             render json: "you have entered wrong pin!!!!."
           end
        end
    end

    def transfer
        byebug
        @transfer_money = params[:transfer_money]
        @user1 = User.find_by(id: params[:user_id])
        @user2 = User.find_by(id: params[:id])
        if @user1&&@user2.present?
            @amount1 = @user1.amount
            @amount2 = @user2.amount
            @pin = @user1.pin
            if @pin == params[:pin].to_i
                if @transfer_money.to_i <= @amount1 
                    @t_money = @amount1-@transfer_money.to_i 
                    @ta_money =  @amount2+@transfer_money.to_i
                    @user1.update(amount: @t_money)
                     @user2.update(amount: @ta_money)
                      @t = Transaction.create(user_id: @user1.id, t_amount: @transfer_money, transaction_type: "transfer")
                      @t = Transaction.create(user_id: @user2.id, t_amount: @transfer_money, transaction_type: "receive")

                     render json: "you have transfered money...."
                else
                    render json: "you can not transfer money!!!!"
                end
            else
                render json: "you have entered wrong pin!!!!"
            end
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :amount, :pin)
    end
end
