using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Net;
using System.Net.Sockets;
using System.Linq;
using System;
using System.IO;
using System.Text;
using System.Globalization;
public class conexion : MonoBehaviour
{
    TcpListener listener;
    public String msg;
    private int contador;
    public static conexion control;

    // Start is called before the first frame update
    void Awake()
    {
        if(control == null)
        {
            control = this;
            DontDestroyOnLoad(gameObject);
        }else if(control != this)
        {
            Destroy(gameObject);
        }
    }
    void Start()
    {
        listener = new TcpListener(IPAddress.Parse("127.0.0.1"), 55001);
        listener.Start();
        print("is listening");
        msg = "-1 -1";
        contador = 0;

    }

    // Update is called once per frame
    void Update()
    {
        if (!listener.Pending())
        {
            if (contador == 50)
            {
                msg = "-1 -1";
                contador = 0;
            }
            contador += 1;
        }
        else
        {
            TcpClient client = listener.AcceptTcpClient();
            NetworkStream ns = client.GetStream();
            StreamReader reader = new StreamReader(ns);
            msg = reader.ReadToEnd();
            contador = 0;
        }
    }
}