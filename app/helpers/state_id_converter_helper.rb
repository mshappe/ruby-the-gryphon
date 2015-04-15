module StateIdConverterHelper
  STATE_IDS = %w[AZ AK AL AR CA CO CT DE DC FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC
                  ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY AB BC MB NB NL NT NS NU ON PE QC SK YT]


  def id_to_code(id)
    raise RangeError.new(t('state_id_warning')) unless (1..STATE_IDS.length).cover? id
    STATE_IDS[id-1]
  end
end
