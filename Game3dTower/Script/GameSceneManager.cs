using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameSceneManager : MonoBehaviour
{
    private void Start()
    {
        Time.timeScale = 1f;
    }
    public void LoadLevel1()
    {
        SceneManager.LoadScene("�ؿ�1");
    }
    public void LoadLevel2()
    {
        SceneManager.LoadScene("�ؿ�2");
    }
    public void SelectLevel()
    {
        SceneManager.LoadScene("�ؿ�ѡ��");
    }
    public void MainScene()
    {
        SceneManager.LoadScene("������");
    }
    public void OnExitGame()
    {
    #if UNITY_EDITOR
            UnityEditor.EditorApplication.isPlaying = false;
    #else
                Application.Quit();
    #endif
    }
}
