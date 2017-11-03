//
//  ViewController.swift
//  Pokedex
//
//  Created by dvt on 2017/10/31.
//  Copyright © 2017 dvt. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    private var pokemons = [Pokemon]()
    private var musicPlayer:AVAudioPlayer!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let pokemonCSVParser = PokemonCSVParser()
        pokemons = pokemonCSVParser.pokemons
        configureAudioPlayer()
    }
    
    @IBAction func onMusicButtonPressed(_ sender: Any) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            (sender as! UIButton).alpha = 0.3
        } else {
            musicPlayer.play()
            (sender as! UIButton).alpha = 1.0
        }
    }
    
    func configureAudioPlayer(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        do{
            let url = URL(string: path)!
            musicPlayer = try AVAudioPlayer(contentsOf: url)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
}

extension ViewController: UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonCell", for: indexPath) as? PokemonCell {
            let pokemon = pokemons[indexPath.row]
            cell.configurCell(with: pokemon)
            return cell
        }
        return UICollectionViewCell()
    }
    
}
extension ViewController: UICollectionViewDelegate{
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 120)
    }
}