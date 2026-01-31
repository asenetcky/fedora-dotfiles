# Quick Start: Enable Image Signing

This is a quick reference for enabling cosign image signing. For detailed
information, see [SIGNING.md](SIGNING.md).

## 5-Minute Setup

### 1. Install Cosign

```bash
COSIGN_VERSION="v2.4.1"
wget "https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/cosign-linux-amd64"
chmod +x cosign-linux-amd64
sudo mv cosign-linux-amd64 /usr/local/bin/cosign
```

### 2. Generate Keys

```bash
cd ~/fedora-dotfiles
cosign generate-key-pair
# Enter a strong password when prompted
```

This creates:
- `cosign.key` (private - never commit!)
- `cosign.pub` (public - commit this)

### 3. Commit Public Key

```bash
git add cosign.pub
git commit -m "Add cosign public key for image verification"
git push
```

### 4. Add GitHub Secrets

Go to: **Settings** → **Secrets and variables** → **Actions**

Add two secrets:

| Name | Value |
|------|-------|
| `SIGNING_SECRET` | Entire contents of `cosign.key` |
| `COSIGN_PASSWORD` | Your password from step 2 |

### 5. Build & Sign

That's it! Your next GitHub Actions build will automatically sign images.

## Verifying It Works

After the build completes, check the Actions logs for:
```
✓ Image signed successfully
```

## Using Signed Images

When rebasing, use the signed variant:

```bash
sudo ostree admin pin 0
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/YOUR-USERNAME/silverblue-custom:latest
systemctl reboot
```

## Troubleshooting

- **Build fails with "Unable to find key pair"**: Check that `SIGNING_SECRET` is set
- **"Invalid password"**: Verify `COSIGN_PASSWORD` matches your key password
- **Want to skip password?**: Regenerate with `cosign generate-key-pair` (press Enter when prompted)

For more help, see [SIGNING.md](SIGNING.md).
