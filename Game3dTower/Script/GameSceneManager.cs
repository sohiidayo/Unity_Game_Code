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
        SceneManager.LoadScene("关卡1");
    }
    public void LoadLevel2()
    {
        SceneManager.LoadScene("关卡2");
    }
    public void SelectLevel()
    {
        SceneManager.LoadScene("关卡选择");
    }
    public void MainScene()
    {
        SceneManager.LoadScene("主界面");
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
