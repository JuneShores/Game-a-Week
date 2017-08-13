#include <iostream>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <vector>

using namespace std;

int main()
{
    std::vector<int> initDeck = {1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10};
    std::vector<int> deck = initDeck;

    int score;
    score = 0;

    srand(time(NULL));

    int state = 3;

    int play = 1;

    while (play == 1) {
        switch(state){
            case 0: {
                cout << "It's a blackjack!";
                score = 0;
                deck = initDeck;
                state = 3;
            }
            break;
            case 1: {
                cout << "What's your move?\n\nType 'Hit' to receive a card, type 'Pass' to end the game:\n\n";

                string* response = NULL;
                response = new string;
                cin >> *response;

                if ((*response == "hit") || (*response == "Hit")) {
                    cout << "\n\nBam.\n\n";
                    // Get random number based on cards left in deck. Decrement deck card amount tracker afterward.
                    int* card = NULL;
                    card = new int;
                    *card = rand() % deck.size();
                    // Print card value.
                    cout << deck[*card] << "!\n\n";
                    // Modify score.
                    score += deck[*card];
                    //Display score.
                    cout << "Your score is... " << score << "\n\n";
                    // Take card out of deck.
                    deck.erase(deck.begin()+*card);
                    delete response;
                    delete card;

                    if (score < 21) {
                        state = 1;
                    } else if (score == 21) {
                        state = 0;
                    } else if (score > 21) {
                        state = 2;
                    }
                } else if ((*response == "pass") || (*response == "Pass")) {
                    cout << "\n\nAre you sure you want to end the game? [y/n]";
                    string response;
                    cin >> response;
                    if ((response == "Y") || (response == "y")) {
                        cout << "\n\nGood game.\n\n=======================\n\n";
                        state = 3;
                    } else if ((response == "N") || (response == "n")) {
                        cout << "Let's go.\n\n";
                        score = 0;
                        deck = initDeck;
                        }

                    } else {
                    cout << "\n\nSorry, what was that?\n\n";
                }
            }
            break;
            case 2: {
                cout << "\n\nGame over! You went too far.\n\n=======================\n\n";
                score = 0;
                deck = initDeck;
                state = 3;
            }
            case 3: {
                cout << "\n\nLet's play Blackjack. I'll deal.\n\n...\n\nShuffled the cards. Here's the first:\n\n";


                int* card = NULL;

                card = new int;
                *card = rand() % deck.size();
                // Print card value.
                cout << deck[*card] << "!\n\n";
                // Modify score.
                score = deck[*card];
                //Display score.
                cout << "Your score is..." << score << "\n\n";
                // Take card out of deck.
                deck.erase(deck.begin()+*card);
                state = 1;
                delete card;
            }
        }
    }
    return 0;
}
