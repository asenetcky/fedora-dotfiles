# Image Signing Setup Guide

This guide explains how to set up container image signing for your custom
Fedora Silverblue image using Cosign.

## Why Sign Container Images?

Image signing provides:

- **Authenticity**: Cryptographic proof that you built the image
- **Integrity**: Assurance that the image hasn't been tampered with
- **Trust**: Users can verify images before deployment
- **Compliance**: Required for some organizational policies

## Prerequisites

- A GitHub account with this repository forked
- Cosign installed locally (for key generation)

## Step 1: Install Cosign Locally

Download and install Cosign from the official releases:

```bash
# On Linux (using version 2.4.1 - check releases for latest)
COSIGN_VERSION="v2.4.1"
wget "https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/cosign-linux-amd64"
chmod +x cosign-linux-amd64
sudo mv cosign-linux-amd64 /usr/local/bin/cosign

# Verify installation
cosign version
```

For other platforms, see: https://github.com/sigstore/cosign/releases

## Step 2: Generate Cosign Key Pair

Generate a new key pair for signing your images:

```bash
# Navigate to your repository root
cd ~/fedora-dotfiles

# Generate the key pair
cosign generate-key-pair

# You'll be prompted for a password
# IMPORTANT: Remember this password - you'll need it later!
```

This creates two files:

- `cosign.key` - **Private key** (keep this secret!)
- `cosign.pub` - **Public key** (commit this to your repo)

## Step 3: Add the Public Key to Your Repository

```bash
# Add the public key to version control
git add cosign.pub
git commit -m "Add cosign public key for image verification"
git push
```

**Note**: Never commit `cosign.key` - it should remain private!

## Step 4: Add Private Key to GitHub Secrets

1. **Copy the private key contents**:

   ```bash
   cat cosign.key
   ```

   Copy the entire output including the header and footer lines.

2. **Add to GitHub Secrets**:
   - Go to your repository on GitHub
   - Navigate to **Settings** → **Secrets and variables** → **Actions**
   - Click **New repository secret**
   - Name: `SIGNING_SECRET`
   - Value: Paste the entire contents of `cosign.key`
   - Click **Add secret**

3. **Add the password as a secret** (if you used one):
   - Click **New repository secret** again
   - Name: `COSIGN_PASSWORD`
   - Value: The password you entered when generating the key
   - Click **Add secret**

## Step 5: Update the GitHub Workflow

The workflow is already configured to use `SIGNING_SECRET`. Once you've added
the secret, the next build will automatically sign your images.

## Step 6: Verify the Setup

After pushing changes and the workflow completes successfully:

1. Check the GitHub Actions logs for signing confirmation
2. Your image will be signed and pushed to the container registry

## Verifying Signed Images

Users can verify your signed images using your public key:

```bash
# Method 1: If you have the repository cloned
cd ~/fedora-dotfiles
cosign verify --key cosign.pub \
  ghcr.io/YOUR-USERNAME/silverblue-custom:latest

# Method 2: Download the public key (verify HTTPS is used)
wget https://raw.githubusercontent.com/YOUR-USERNAME/fedora-dotfiles/main/cosign.pub

# Verify the downloaded key fingerprint matches what you expect
# (Get the expected fingerprint from repository owner through a trusted channel)

# Then verify the image
cosign verify --key cosign.pub \
  ghcr.io/YOUR-USERNAME/silverblue-custom:latest
```

**Security Note**: Always verify the public key fingerprint through a separate
trusted channel (e.g., direct communication with the repository owner) before
using it to verify images.

## Rebasing to a Signed Image

Once signing is set up, you can rebase to the signed image:

```bash
# Pin current deployment (for easy rollback)
sudo ostree admin pin 0

# Rebase to the signed image (verified registry)
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/YOUR-USERNAME/silverblue-custom:latest

# Reboot to apply
systemctl reboot
```

**Note**: Use `ostree-image-signed` instead of `ostree-unverified-registry` when
using signed images.

## Security Best Practices

1. **Never commit `cosign.key`** - Add it to `.gitignore`
2. **Use a strong password** for your private key
3. **Backup your keys** securely (encrypted storage)
4. **Rotate keys periodically** for better security
5. **Don't share your `SIGNING_SECRET`** with anyone

## Troubleshooting

### "Unable to find private/public key pair"

- Ensure `SIGNING_SECRET` is properly set in GitHub Secrets
- Check that the secret contains the full key including headers/footers
- Verify the workflow has access to repository secrets

### "Invalid signature"

- Ensure you're using the correct `cosign.pub` file
- Check that the image was built after setting up signing
- Verify the image tag matches what was signed

### "Password required but not provided"

- Add `COSIGN_PASSWORD` secret to GitHub Secrets
- Or regenerate keys without a password: `cosign generate-key-pair`
  (when prompted, press Enter for no password)

## Disabling Signing

If you want to disable signing temporarily:

1. Go to repository **Settings** → **Secrets and variables** → **Actions**
2. Delete the `SIGNING_SECRET` secret
3. The workflow will skip signing on the next build

## Additional Resources

- [Sigstore Cosign Documentation](https://docs.sigstore.dev/cosign/overview/)
- [BlueBuild Signing Guide](https://blue-build.org/how-to/cosign/)
- [GitHub Actions Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
