//
//  ViewController.swift
//  ApplePie
//
//  Created by Kseniia Agibalova on 28.08.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: -IB Outlets
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var TreeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    //MARK: -Properties
    var currentGame: Game!
    let incorrectMovesAllowed = 7
    var listOfWords =
              ["Александрия",
               "Атланта",
               "Ахмедабад",
               "Багдад",
               "Бангалор",
               "Бангкок",
               "Барселона",
               "Белу-Оризонти",
               "Богота",
               "Буэнос-Айрес",
               "Вашингтон",
               "Гвадалахара",
               "Гонконг",
               "Гуанчжоу",
               "Дакка",
               "Даллас",
               "Далянь",
               "Дар-эс-Салам",
               "Дели",
               "Джакарта",
               "Дунгуань",
               "Йоханнесбург",
               "Каир",
               "Калькутта",
               "Карачи",
               "Киншаса",
               "Куала Лумпур",
               "Лагос",
               "Лахор",
               "Лима",
               "Лондон",
               "Лос-Анджелес",
               "Луанда",
               "Мадрид",
               "Майами",
               "Манила",
               "Мехико",
               "Москва",
               "Мумбаи",
               "Нагоя",
               "Нанкин",
               "Нью-Йорк",
               "Осака",
               "Париж",
               "Пекин",
               "Пуна",
               "Рио-де-Жанейро",
               "Сан-Паулу",
               "Санкт-Петербург",
               "Сантьяго",
               "Сеул",
               "Сиань",
               "Сингапур",
               "Стамбул",
               "Сурат",
               "Сучжоу",
               "Тегеран",
               "Токио",
               "Торонто",
               "Тяньцзинь",
               "Ухань",
               "Филадельфия",
               "Фошань",
               "Фукуока",
               "Хайдарабад",
               "Ханчжоу",
               "Харбин",
               "Хартум",
               "Хошимин",
               "Хьюстон",
               "Цзинань",
               "Циндао",
               "Ченнай",
               "Чикаго",
               "Чунцин",
               "Чэнду",
               "Шанхай",
               "Шэньчжэнь  ",
               "Шэньян",
               "Эр-Рияд",
               "Янгон"
              ].shuffled()
    var totalWins = 0 {
        didSet { newRound()
            
        }
    }
    var totalLosses = 0 {
        didSet { newRound()
        }
    }
    //MARK: - Methods
    func enableButtons(_ enable: Bool = true) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    func newRound() {
        guard !listOfWords.isEmpty else {
            enableButtons(false)
            updateUI()
            return
        }
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed)
        updateUI()
        enableButtons()
    }
    func updateCorrectWordLabel() {
        var displayWord = [String] ()
        for Letter in currentGame.guessedWord {
            displayWord.append(String(Letter))
        }
        correctWordLabel.text = displayWord.joined(separator:" ")
        
    }
    func updateState(){
        if currentGame.incorrectMovesRemaining < 1 {
           totalLosses += 1
        } else if currentGame.guessedWord == currentGame.word {
          totalWins += 1
        } else {
            updateUI() }
    }
    func updateUI() {
        let movesRemaining = currentGame.incorrectMovesRemaining
        let imageNumber = (movesRemaining + 64) % 8
        let image = "Tree\(imageNumber)"
        TreeImageView.image = UIImage(named: image)
        updateCorrectWordLabel()
        scoreLabel.text = "Выигрыши: \(totalWins), проигрыши: \(totalLosses)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       newRound()
    }
    
    
// MARK: -IB Actions

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = sender.title(for: .normal)!
        currentGame.playerGuessed(letter: Character(letter))
        updateState()
    }
}

