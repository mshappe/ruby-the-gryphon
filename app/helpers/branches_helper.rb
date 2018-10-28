module BranchesHelper
  NS_STATE_NAMES = {
    'MB' => 'Manitoba, Canada',
    'MI' => 'Upper Peninsula Michigan',
    'MN' => 'Minnesota',
    'ND' => 'North Dakota',
    'ON' => 'Northern Ontario, Canada',
    'SD' => 'South Dakota',
    'WI' => 'Wisconsin'
  }.freeze

  NS_STATE_SUBTITLES = {
    'MI' => 'Lower Michigan is part of the Middle Kingdom',
    'ON' => 'The rest of Ontario is part of the Kingdom of Ealdormere'
  }.freeze

  def ns_state_name(code)
    NS_STATE_NAMES[code]
  end

  def ns_state_subtitle(code)
    NS_STATE_SUBTITLES[code]
  end
end
