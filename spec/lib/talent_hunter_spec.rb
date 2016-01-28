require_relative '../../lib/models/player'
require_relative '../../lib/talent_hunter_with_naive_query'
require_relative '../../lib/talent_hunter_with_query_object'

shared_examples "finds the good player" do
  let!(:good_forward) do
    Player.create(
      goals: 75,
      shoots: 100,
      birth_date: Date.parse('1995-10-28'),
      team_name: 'ac milan',
      preferred_foot: 'right'
    )
  end

  let!(:horrible_forward) do
    Player.create(
      goals: 45,
      shoots: 100,
      birth_date: Date.parse('1965-10-28'),
      team_name: 'nowhere city',
      preferred_foot: 'left'
    )
  end

  let(:options) do
    {
      playing_for_top_team: true,
      with_young_age: true,
      with_great_accuracy: true
    }
  end

  subject { described_class.new(options) }

  specify do
    expect(subject.find_good_forward.first.id).to eq(good_forward.id)
  end

  specify do
    expect(subject.find_good_forward.count).to eq(1)
  end

  context 'not playing for a big team' do
    let(:options) do
      {
        playing_for_top_team: false,
        with_young_age: true,
        with_great_accuracy: true
      }
    end

    let!(:good_forward_no_big_team) do
      Player.create(
        goals: 75,
        shoots: 100,
        birth_date: Date.parse('1995-10-28'),
        team_name: 'nowhere city',
        preferred_foot: 'right'
      )
    end

    specify do
      expect(subject.find_good_forward.count).to eq(1)
    end

    specify do
      expect(subject.find_good_forward.first.id).to eq(good_forward_no_big_team.id)
    end
  end

  context 'without great shoot accuracy' do
    let(:options) do
      {
        playing_for_top_team: true,
        with_young_age: true,
        with_great_accuracy: false
      }
    end

    let!(:good_forward_no_great_accuracy) do
      Player.create(
        goals: 55,
        shoots: 100,
        birth_date: Date.parse('1995-10-28'),
        team_name: 'ac milan',
        preferred_foot: 'right'
      )
    end

    specify do
      expect(subject.find_good_forward.count).to eq(1)
    end

    specify do
      expect(subject.find_good_forward.first.id).to eq(good_forward_no_great_accuracy.id)
    end
  end

  context 'old' do
    let(:options) do
      {
        playing_for_top_team: true,
        with_young_age: false,
        with_great_accuracy: true
      }
    end

    let!(:good_forward_but_old) do
      Player.create(
        goals: 95,
        shoots: 100,
        birth_date: Date.parse('1965-10-28'),
        team_name: 'ac milan',
        preferred_foot: 'right'
      )
    end

    specify do
      expect(subject.find_good_forward.count).to eq(1)
    end

    specify do
      expect(subject.find_good_forward.first.id).to eq(good_forward_but_old.id)
    end
  end
end

describe TalentHunterWithNaiveQuery do
  include_examples "finds the good player"
end

describe TalentHunterWithQueryObject do
  include_examples "finds the good player"
end
