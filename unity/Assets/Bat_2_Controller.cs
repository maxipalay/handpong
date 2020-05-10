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


public class Bat_2_Controller : MonoBehaviour
{

    private Rigidbody2D rb;
 
    public static Vector2 topRight;

    public string msg2;

    private conexion conex;

    float pala2;
    // Use this for initialization
    void Start()
    {
        rb = this.GetComponent<Rigidbody2D>();
       float height = transform.localScale.y;
        topRight = Camera.main.ScreenToWorldPoint(new Vector2(Screen.width, Screen.height));
        conex = GameObject.FindGameObjectWithTag("control_net").GetComponent<conexion>();


    }

    // Update is called once per frame
    void Update()
    {

        msg2 = conex.msg;
        char delimitador = (' ');
        string[] trozos = msg2.Split(delimitador);
        pala2 = float.Parse(trozos[0], NumberStyles.Float, CultureInfo.InvariantCulture);

        //El 5f es la velocidad de la pala.
        if (pala2 < 140 && pala2 != -1)
        {
            rb.velocity = new Vector2(0f, 6f);
        }
        else if (pala2 > 160)
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

     
            //Ponemos la pala a la parte derecha
            pos = new Vector2(topRight.x, 0);
            pos -= Vector2.right * transform.localScale.x; //para que salgan centrada

        transform.position = pos;
       
    }
}
