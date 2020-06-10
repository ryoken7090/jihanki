class VendingMachine
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @slot_money = 0
    @earned_money = 0
  end
  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts @slot_money
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end

  def products
    juice = Juice.new("コーラ", 120, 5)
    @juice_name = juice.name
    @juice_price = juice.price
    @juice_stock = juice.stock
  end
  def able_to_sell
    if @slot_money >= @juice_price
      if @juice_stock > 0
        puts "購入可能です。"
        return true
      else
        puts "在庫がありません。"
        return false
      end
    else
      puts "投入金額が不足しています。"
      return false
    end
  end
  def sell
    if able_to_sell
      @juice_stock -= 1
      @earned_money += @juice_price
      @slot_money -= @juice_price
      puts @juice_stock
      puts @earned_money
    end
  end
end

class Juice
  attr_reader :name, :price, :stock
  def initialize(name, price, stock)
    @name = name
    @price = price
    @stock = stock
  end
end

vm = VendingMachine.new
vm.products
vm.slot_money(500)
vm.sell
vm.return_money