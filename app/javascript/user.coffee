$ ->
  $("#customer_postcode").jpostal({
    postcode : [ "#customer_postcode" ],
    address  : {
                  '#address' : '%3%4%5'
                }
  });
  
  # 入力項目フォーマット
    #   %3  都道府県
    #   %4  市区町村
    #   %5  町域
    #   %6  大口事業所の番地
    #   %7  大口事業所の名称