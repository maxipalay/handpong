using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class Count_Score : MonoBehaviour {
    public Text ScoreBoard;
    public GameObject ball;

    private int Bat_1_Score = 0;
    private int Bat_2_Score = 0;


    // Use this for initialization
    void Start () {
        ball = GameObject.Find("Ball");
	}
	
	// Update is called once per frame
	void Update () {
        if (ball.transform.position.x >= 17f)
        {
            Bat_1_Score++;
        }
        if (ball.transform.position.x <= -17f)
        {
            Bat_2_Score++;
        }
        ScoreBoard.text = Bat_1_Score.ToString() + "  " + Bat_2_Score.ToString();

       if(Bat_1_Score == 7)
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
        }
        if (Bat_2_Score == 7)
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 2);
        }


    }
}
