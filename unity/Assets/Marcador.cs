using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class Marcador : MonoBehaviour {

    public Text ScoreBoard;
    public GameObject ball;

    private int Bat_1_Score = 0;



    // Use this for initialization
    void Start()
    {
        ball = GameObject.Find("Pelota");
    }

    // Update is called once per frame
    void Update()
    {
        if (ball.transform.position.x >= 17f)
        {
            Bat_1_Score++;
        }

        ScoreBoard.text = Bat_1_Score.ToString();


        if (Bat_1_Score == 4)
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
        }



    }
}
