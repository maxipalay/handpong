using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using System.Net;
using System.Net.Sockets;
using System;
using System.IO;
using System.Text;
using System.Globalization;
using System.Linq;

public class Bat_1_Controller : MonoBehaviour {

    private Rigidbody2D rb;
    public static Vector2 bottomLeft;

    public string msg1;

    private conexion conex;

    float pala1;

    // Use this for initialization
    void Start () {
        rb = this.GetComponent<Rigidbody2D>();
        bottomLeft = Camera.main.ScreenToWorldPoint(new Vector2(0, 0));
        conex = GameObject.FindGameObjectWithTag("control_net").GetComponent<conexion>();
      
    }
	
	// Update is called once per frame
	void Update () {

        msg1 = conex.msg;
        char delimitador = (' ');
        string[] trozos = msg1.Split(delimitador);
        pala1 = float.Parse(trozos[1], NumberStyles.Float, CultureInfo.InvariantCulture);

        //El 5f es la velocidad de la pala.
        if (pala1 < 140 && pala1 != -1)
        {
            rb.velocity = new Vector2(0f,6f);
        }
        else if (pala1 > 160)
        {
            rb.velocity = new Vector2(0f, -6f);
        }
        else
        {
            rb.velocity = new Vector2(0f, 0f);
        }

    }

    public void Init()
    {


        Vector2 pos = Vector2.zero;

            pos = new Vector2(bottomLeft.x, 0);
            pos += Vector2.right * transform.localScale.x; //para que salgan centrada

      
        transform.position = pos;

    }
}
