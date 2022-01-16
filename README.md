# MathDataBase

## Software requirement
Requirements:

* **GitHub Desktop** (with english UI)
* **Visual Studio Code**

Some explanations can be slightly inaccurate because they implicitly refer to specific versions of these softwares.

## Contributions with git

### GitHub account

Create a GitHub account, enable **Two-factor authentication** in `Settings/Account security`

In order to use `git` on the command line, generate a
`Personal access token` in `Settings/Developer settings`.

### Starting point

Make a fork of the original `MathDataBase-fr` repository.

1. Go to [GitHub](https://github.com/)
2. sign in with your user account
3. Goto [uB-MEEF-Maths-2021](https://github.com/uB-MEEF-Maths-2021/MathDataBase-fr)
4. Press the **fork** button
5. Fill the form keeping things public.

This creates your personal forked repository at `https://github.com/<your user name>/MathDataBase-fr`. Then you make a local working copy of this forked repository. From this page,

5. Choose the `Code` tab
6. From the green `Code` drowdown choose **Open with GitHub Desktop**
7. Fill the GitHub Desktop form

### Make changes

Once changes are made to your local copy,

1. Open GitHub Desktop
2. Set the current repository
3. Switch to the **Changes** tab

you can see the actual changes that you should **commit**:

4. Press the blue **Commit to main** button

Once commits are made, you **push** them to the server:

5. Press the blue **Push** button

### Contribute to the original MathDataBase

First you have to fetch any change made by third parties.

1. Open **GitHub Desktop**
2. Select menu **Branch→Merge into current branch...**
3. Select **upstream/main**
4. **Create a merge commit**

If you are asked to resolve conflicts before merge,

* for binary files select **Resolve→Use the modified file from `upstream/main`**
* for text files, select **Open in visual studio code**. In each open window, navigate to each conflicting zone and select one of **Accept current change**, **Accept incoming change**, **Accept both changes**, **Compare changes** or make the changes manually if you have enough skills.
* Once all conflicts are resolved, click **Continue merge**

Then you should push this **merge commit**.

Now you create a pull request.

1. In **Github Desktop** select menu **Branch→Create pull request**
2. Press the green **Create pull request** button

Then some people will review your changes, and possibly integrate them into the official **MathDataBase**.

## Advanced features

Nothing yet
